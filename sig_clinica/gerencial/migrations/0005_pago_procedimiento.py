# Generated by Django 2.2.2 on 2019-06-21 11:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gerencial', '0004_auto_20190619_0116'),
    ]

    operations = [
        migrations.AddField(
            model_name='pago',
            name='procedimiento',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='gerencial.Procedimiento'),
        ),
    ]

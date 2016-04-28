From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: support for fixed 1.8V eMMC interface
Date: Thu, 28 Apr 2016 20:15:17 +0800
Message-ID: <CAA+hA=RxSkCH1XiYUpB5c=2h4GpM2aOND6fdmizeBWu8F_A4zQ@mail.gmail.com>
References: <VI1PR05MB15338BD748ACE3938D3E4B339B640@VI1PR05MB1533.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:33617 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbcD1MPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 08:15:18 -0400
Received: by mail-qg0-f65.google.com with SMTP id 7so2200606qgj.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 05:15:18 -0700 (PDT)
In-Reply-To: <VI1PR05MB15338BD748ACE3938D3E4B339B640@VI1PR05MB1533.eurprd05.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Raul Benet <Raul.Benet@lightblueoptics.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 27, 2016 at 7:44 PM, Raul Benet
<Raul.Benet@lightblueoptics.com> wrote:
> Hi,
>
> I am currently working on a design using i.MX6SL and Linux Kernel 3.14.52. Though I believe may question still applies to latest MMC code.
> Our design uses an eMMC as boot device and main storage (ie: it contains u-boot, kernel, dtb and rootfs).
>
> The eMMC I/O rail is fixed in hardware to 1.8Volts.
> The Processor SDIO I/O rail is controlled by the MMC driver.
>
> In 3.14.52, the MMC driver sets processor SDIO rail to 3v3 per default, and only when using HS DDR modes (which do not apply in our case) would it set it to 1.8V.
>
> I have seen that starting on 3.16, the function power_up() in drivers/mmc/core/core.c attempts at setting the regulator to 3v3, failing that it tries 1v8, failing that it tries 1v2.
>
> So I patched my kernel with that, and defined a fixed regulator with 1v8 in my dts, and set the vqmmc-supply to point to it.
> But that doesn't work, because power_up() ultimately tries to call set_voltage() on the vqmmc regulator, which doesn't seem to exist for "regulator-fixed" type of regulators, and hence it fails in setting all the rails, which ultimately means that it sets it to 3v3 ('cause that is the default/initial value of the field in the ios struct)
>

It seems the 3.6 kernel you tried may still not support set voltage
for fixed regulator.
But i tried the latest kernel already supports it.

> So my question is: how am I supposed to setup the MMC driver in my scenario (I/O at 1.8V always) ?
> (I know I can go and force the rail to 1.8V by hacking drivers/mmc/host/sdhci-esdhc-imx.c, but I would very much prefer to avoid that)
>

Pls try the option 2 as Ulf pointed.

You can refer to this patch:
commit c00dc359e5e0b10de993651d8e73e60c41bf29cd
Author: Bjorn Andersson <bjorn@kryo.se>
Date:   Wed Feb 5 12:30:26 2014 -0800

    regulator: core: Allow regulator_set_voltage for fixed regulators

    Make it okay to call regulator_set_voltage on regulators with fixed
    voltage if the requested range overlaps the current/configured voltage.

    Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
    Signed-off-by: Mark Brown <broonie@linaro.org>

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b38a6b669e8c..0cd1a3b8e589 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2395,6 +2395,7 @@ int regulator_set_voltage(struct regulator
*regulator, int min_uV, int max_uV)
        struct regulator_dev *rdev = regulator->rdev;
        int ret = 0;
        int old_min_uV, old_max_uV;
+       int current_uV;

        mutex_lock(&rdev->mutex);

@@ -2405,6 +2406,19 @@ int regulator_set_voltage(struct regulator
*regulator, int min_uV, int max_uV)
        if (regulator->min_uV == min_uV && regulator->max_uV == max_uV)
                goto out;

+       /* If we're trying to set a range that overlaps the current voltage,
+        * return succesfully even though the regulator does not support
+        * changing the voltage.
+        */
+       if (!(rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE)) {
+               current_uV = _regulator_get_voltage(rdev);
+               if (min_uV <= current_uV && current_uV <= max_uV) {
+                       regulator->min_uV = min_uV;
+                       regulator->max_uV = max_uV;
+                       goto out;
+               }
+       }
+
        /* sanity check */
        if (!rdev->desc->ops->set_voltage &&
            !rdev->desc->ops->set_voltage_sel) {

Regards
Dong Aisheng

> Thanks ,
> Raul.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

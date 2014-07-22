From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Tue, 22 Jul 2014 21:31:39 +0200
Message-ID: <CABxcv=nuxnEpq--1FfZ2cnyKUrrg9U6DEk5Lozy+ntHYNk0UbQ@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
	<CAKuRcO+OaknUtj9mJ+SQJPMj70hdLTMkDYCXq4L5JdwzDKdj6g@mail.gmail.com>
	<CAD=FV=Vy5vRan0KEDFFwVO0omgsUMwJK6WwCsWxGYynzT-e5ig@mail.gmail.com>
	<CAKuRcOLDCFQnw01ReKqNNfiiCwSWwi6Rd7UZFph+JzK2CQ4T_w@mail.gmail.com>
	<CAD=FV=WhTdyinkmZFVW5VxK1m-1Z=gMmofBU1RC0t82oEDEZzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61446 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbaGVTbm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jul 2014 15:31:42 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so6571417wib.9
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jul 2014 12:31:40 -0700 (PDT)
In-Reply-To: <CAD=FV=WhTdyinkmZFVW5VxK1m-1Z=gMmofBU1RC0t82oEDEZzA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hello Yuvaraj,

On Sat, Jun 28, 2014 at 12:47 AM, Doug Anderson <dianders@chromium.org> wrote:
> On Fri, Jun 27, 2014 at 3:59 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
>>>> mmc_regulator_set_ocr() is failing as its a fixed-regulator.
>>>
>>> Can you explain more about what's failing?  It sure looks like mmc
>>> core is supposed to handle this given comments below
>>>
>>> /*
>>> * If we're using a fixed/static regulator, don't call
>>> * regulator_set_voltage; it would fail.
>>> */
>> tps65090 driver does not register through fixed regulator framework.It
>> uses normal regulator framework and supports only
>> enable/disable/is_enabled callbacks.Also it lacks certain callbacks
>> for list_voltage, get_voltage ,set_voltage etc.
>> [    2.306476] dwmmc_exynos 12220000.mmc: Failed getting OCR mask: -22
>> [    2.393403] dwmmc_exynos 12220000.mmc: could not set regulator OCR (-22)
>> For the above reason,regulator framework treats fet4 as unused
>> regulator and disables the vmmc regulator.
>
> Ah.  Perhaps tps65090 needs to be fixed then...  I'm not sure any
> other drivers cared before so maybe that's why it was never caught?
>

I've been looking at this and as Doug and you said it seems that
nobody cared and since the tps65090 fets are actually just load
switches the driver only implementes the .enable and .disable
functions handlers. Also since their output voltage is just equal to
their input supply, that information was not present neither in the
driver nor in the Device Tree.

But when fet4 is used as the vmmc-supply phandle,
mmc_regulator_get_supply() calls mmc_regulator_get_ocrmask() [0] which
expects to fetch the regulator voltage count and current voltage as
you had explained so the function was failing.

Now I don't think that the driver needs to implement the
{get,set,list}_voltage callbacks. If a tps65090 regulator has both
regulator-min-microvolt and regulator-max-microvolt properties from
the generic regulator DT binding, and the value is the same, it can be
assumed that the regulator is fixed and the fixed_uV field can be set
to the output voltage and n_voltages to 1. That's everything that the
regulator core needs from a fixed regulator in order to make
regulator_get_voltage() to succeed:

static int _regulator_get_voltage(struct regulator_dev *rdev)
{
...
    if (rdev->desc->ops->get_voltage_sel) {
        sel = rdev->desc->ops->get_voltage_sel(rdev);
        if (sel < 0)
            return sel;
        ret = rdev->desc->ops->list_voltage(rdev, sel);
    } else if (rdev->desc->ops->get_voltage) {
        ret = rdev->desc->ops->get_voltage(rdev);
    } else if (rdev->desc->ops->list_voltage) {
        ret = rdev->desc->ops->list_voltage(rdev, 0);
    } else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
        ret = rdev->desc->fixed_uV;
    } else {
        return -EINVAL;
    }
...
}

What do you think about patch [1]?

So, with that patch mmc_regulator_get_supply() does not fail anymore
and also does not break DT backward compatibility since it only has
effect on the regulators that define their min and max voltage and not
in the ones that don't like is the case in old DTB.

Now, it is an RFC since I don't know if this is the correct solution.
Even though I've seen that min == max seems to imply that the
regulator is fixed, I wonder if is better to have an explicit generic
DT property (regulator-fixed-microvolt?) that is used to set fixed_uV
in of_get_regulation_constraints(). Since this seems to be a general
problem and not only related to the tps65090 device or the Peach
Pit/Pi use case. If you agree that it's a good solution then I can
post it as a proper patch.

I've also pushed this patch and the ones adding the needed DTS bits
for Peach Pit and Pi DTS to my personal repository so you can test it.
The branch is:

http://cgit.collabora.com/git/user/javier/linux.git/log/?h=tps65090-fixes

You also need to replace regulator_enable(mmc->supply.vmmc) and
regulator_disable(mmc->supply.vmmc) by mmc_regulator_set_ocr(mmc,
mmc->supply.vmmc, ios->vdd) and mmc_regulator_set_ocr(mmc,
mmc->supply.vmmc, 0) respectively in your original patch.

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/drivers/mmc/core/core.c#L1215
[1]:
>From 3d2e6079cc8c372da946d430d43d36af99e7a582 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Tue, 22 Jul 2014 19:16:47 +0200
Subject: [RFC] regulator: tps65090: Allow regulators voltage to be
 queried

The tps65090 device has some regulators with a fixed output
voltage and others with an adjustable output voltage. But the
regulators with adjustable output just provide the voltage of
their input supply so they really are fixed regulators within
a supported voltage range that depends on their input voltage.

That is why the driver only provides an .enable and .disable
function handlers and not a .{get,set,list}_voltage handlers.

But there is code in the kernel that expects to query the
output voltage for all regulators. For example the function
mmc_regulator_get_ocrmask() is executed if a regulator is
used as a vmmc supply and this functions tries to fetch the
number of voltages supported by the regulator and its current
voltage but fails since the driver does not provide this data.

The .{list,get}_voltage function handler are actually not even
needed for fixed regulators since in this case the regulator
core just need a fixed voltage and a single voltage selector.

So, let's allow output voltage to be defined using the generic
regulator-min-microvolt and regulator-max-microvolt  properties
and use the same semantic for fixed regulator as explained in
Documentation/devicetree/bindings/regulator/fixed-regulator.txt.
Where having an equal value for min and max microvolt means that
the regulator is fixed and has a single voltage selector.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/tps65090-regulator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/regulator/tps65090-regulator.c
b/drivers/regulator/tps65090-regulator.c
index 2064b3f..673948d 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -408,6 +408,7 @@ static int tps65090_regulator_probe(struct
platform_device *pdev)
     struct of_regulator_match *tps65090_reg_matches = NULL;
     int num;
     int ret;
+    int min_uV, max_uV;

     dev_dbg(&pdev->dev, "Probing regulator\n");

@@ -435,6 +436,19 @@ static int tps65090_regulator_probe(struct
platform_device *pdev)
             ri->overcurrent_wait_valid =
                 tps_pdata->overcurrent_wait_valid;
             ri->overcurrent_wait = tps_pdata->overcurrent_wait;
+
+            min_uV = tps_pdata->reg_init_data->constraints.min_uV;
+            max_uV = tps_pdata->reg_init_data->constraints.max_uV;
+
+            /*
+             * A regulator whose regulator-min-microvolt and
+             * regulator-max-microvolt properties are the same
+             * is a fixed regulator and has a single voltage rail.
+             */
+            if (min_uV && max_uV && min_uV == max_uV) {
+                ri->desc->fixed_uV = min_uV;
+                ri->desc->n_voltages = 1;
+            }
         }

         /*
-- 
2.0.0.rc2

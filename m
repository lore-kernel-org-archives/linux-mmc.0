From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Tue, 29 Mar 2016 14:00:52 +0200
Message-ID: <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
	<CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
	<CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
	<CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
	<20160327090859.GH5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160327090859.GH5028@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Mark,

On Sun, Mar 27, 2016 at 11:08 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 26, 2016 at 04:50:41PM -0700, Bjorn Andersson wrote:
>
>> Reinstating the following snippet in of_get_regulation_constraints()
>> sort this out:
>
>> if (constraints->min_uV && constraints->max_uV)
>>                                        constraints->apply_uV = true;
>
> The existing check in the patch should be an || not an ==, or possibly
> we should just not bother looking for min_uV at all.  I just pushed out
> a version of that, let's see how that goes.

Has the fix really been pushed out?

With commit fa93fd4ecc9c58475abac6db93a797bff893bc16
Author: Mark Brown <broonie@kernel.org>
Date:   Mon Mar 21 18:12:52 2016 +0000

    regulator: core: Ensure we are at least in bounds for our constraints

I see a few cases of

------------[ cut here ]------------
WARNING: CPU: 1 PID: 31 at drivers/regulator/core.c:2223
_regulator_disable+0x2c/0x128
unbalanced disables for SDHI0 VccQ
Modules linked in:
CPU: 1 PID: 31 Comm: kworker/1:1 Not tainted
4.6.0-rc1-koelsch-00724-g58d619227282dc16 #2422
Hardware name: Generic R8A7791 (Flattened Device Tree)
Workqueue: events_freezable mmc_rescan
sh_mobile_sdhi ee140000.sd: could not set regulator OCR (-22)

[<c020e040>] (unwind_backtrace) from [<c0209d70>] (show_stack+0x10/0x14)
[<c0209d70>] (show_stack) from [<c03c7584>] (dump_stack+0x7c/0x9c)
[<c03c7584>] (dump_stack) from [<c021fa48>] (__warn+0xcc/0xfc)
[<c021fa48>] (__warn) from [<c021faac>] (warn_slowpath_fmt+0x34/0x44)
[<c021faac>] (warn_slowpath_fmt) from [<c041e464>]
(_regulator_disable+0x2c/0x128)
[<c041e464>] (_regulator_disable) from [<c041e590>]
(regulator_disable+0x30/0x60)
[<c041e590>] (regulator_disable) from [<c0572e18>] (tmio_mmc_set_ios+0xb8/0x1d4)
[<c0572e18>] (tmio_mmc_set_ios) from [<c056300c>] (mmc_power_off+0x34/0x54)
[<c056300c>] (mmc_power_off) from [<c0563a5c>] (mmc_rescan+0x214/0x30c)
[<c0563a5c>] (mmc_rescan) from [<c0233368>] (process_one_work+0x1bc/0x2f4)
[<c0233368>] (process_one_work) from [<c0233a2c>] (worker_thread+0x2a8/0x3d0)
[<c0233a2c>] (worker_thread) from [<c0237a9c>] (kthread+0xd8/0xec)
[<c0237a9c>] (kthread) from [<c0206b68>] (ret_from_fork+0x14/0x2c)
---[ end trace 1c61a7f6221c11ea ]---

when booting on r8a7791/koelsch.

I'm a bit confused by the discussion of "&&" vs. "||" vs. "==", but the
warnings do go away when using "!=", cfr. the whitespace-damaged patch below.

--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -43,7 +43,7 @@ static void of_get_regulation_constraints(struct device_node *
                constraints->max_uV = pval;

        /* Voltage change possible? */
-       if (constraints->min_uV && constraints->max_uV) {
+       if (constraints->min_uV != constraints->max_uV) {
                constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
                constraints->apply_uV = true;
        }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

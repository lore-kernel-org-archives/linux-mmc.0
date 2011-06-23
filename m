From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Thu, 23 Jun 2011 18:01:40 +0530
Message-ID: <BANLkTi=WnsoETEooK6gsL7jgxf8vuRN97Q@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<874o3hr9tc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46208 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759225Ab1FWMbm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 08:31:42 -0400
In-Reply-To: <874o3hr9tc.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com

On Thu, Jun 23, 2011 at 12:08 AM, Kevin Hilman <khilman@ti.com> wrote:
> Balaji T K <balajitk@ti.com> writes:
>

>> @@ -1880,18 +1873,12 @@ static int __init omap_hsmmc_probe(struct pl=
atform_device *pdev)
>>
>> =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DISABLE;
>>
>> - =A0 =A0 if (clk_enable(host->iclk) !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 if (mmc_host_enable(host->mmc) !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> - =A0 =A0 }
>> + =A0 =A0 pm_runtime_enable(host->dev);
>> + =A0 =A0 pm_runtime_allow(host->dev);
>> + =A0 =A0 pm_runtime_get_sync(host->dev);
>> + =A0 =A0 pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEN=
D_DELAY);
>> + =A0 =A0 pm_runtime_use_autosuspend(host->dev);
>> + =A0 =A0 pm_suspend_ignore_children(host->dev, 1);
>
> Why is ignore_children needed for this device? =A0 Is this device the
> parent of other devices? =A0 If it is, why should it ignore it's
> children?
>

No, I will remove. Added it for testing only.

>> =A0 =A0 =A0 if (cpu_is_omap2430()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dbclk =3D clk_get(&pdev->dev, "mmc=
hsdb_fck");
>> @@ -2018,6 +2005,8 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 omap_hsmmc_debugfs(mmc);
>> + =A0 =A0 pm_runtime_mark_last_busy(host->dev);
>> + =A0 =A0 pm_runtime_put_autosuspend(host->dev);
>>
>> =A0 =A0 =A0 return 0;
>>
>> @@ -2033,8 +2022,8 @@ err_reg:
>> =A0err_irq_cd_init:
>> =A0 =A0 =A0 free_irq(host->irq, host);
>> =A0err_irq:
>> - =A0 =A0 mmc_host_disable(host->mmc);
>> - =A0 =A0 clk_disable(host->iclk);
>> + =A0 =A0 pm_runtime_mark_last_busy(host->dev);
>> + =A0 =A0 pm_runtime_put_autosuspend(host->dev);
>> =A0 =A0 =A0 clk_put(host->fclk);
>> =A0 =A0 =A0 clk_put(host->iclk);
>> =A0 =A0 =A0 if (host->got_dbclk) {
>> @@ -2058,7 +2047,7 @@ static int omap_hsmmc_remove(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 struct resource *res;
>>
>> =A0 =A0 =A0 if (host) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_enable(host->mmc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_remove_host(host->mmc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->use_reg)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reg_put(host)=
;
>> @@ -2069,8 +2058,9 @@ static int omap_hsmmc_remove(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mmc_slot(host).=
card_detect_irq, host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_work_sync(&host->mmc_carddetect_wo=
rk);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->iclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_forbid(host->dev);
>
> Why?
>

Added for balancing pm_runtime_allow added in  _probe.
But forbid also resume the device on remove.
Should this be removed, keeping _allow in _probe ?

>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(host->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->iclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk) {
>> @@ -2102,6 +2092,8 @@ static int omap_hsmmc_suspend(struct device *d=
ev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 if (host) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: TODO move get_sync to proper dev=
_pm_ops function */
>
> what does this mean?

get_sync is needed to enable clock before accessing the registers but
the discusssion @
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50819.html
suggested to move runtime get_sync calls to .prepare
Haven't tried it yet.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->suspended =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata->suspend) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->pdata->sus=
pend(&pdev->dev,
>> @@ -2116,13 +2108,11 @@ static int omap_hsmmc_suspend(struct device =
*dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_work_sync(&host->mmc_carddetect_w=
ork);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_suspend_host(host->mmc);
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_enable(host->mmc);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_disable_irq(h=
ost);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->b=
ase, HCTL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSM=
MC_READ(host->base, HCTL) & ~SDBP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->iclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disa=
ble(host->dbclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> @@ -2134,8 +2124,9 @@ static int omap_hsmmc_suspend(struct device *d=
ev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 dev_dbg(mmc_dev(host->mmc),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 "Unmask interrupt failed\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: TODO move put_sync to proper dev=
_pm_ops function */
>
> ditto
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
>>
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return ret;
>> @@ -2152,14 +2143,8 @@ static int omap_hsmmc_resume(struct device *d=
ev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 if (host) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_enable(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clk_en_err;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_host_enable(host->mmc) !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clk_en_err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: TODO move put_sync to proper dev=
_pm_ops function */
>
> comment says put_sync, code says get_sync, but again, comment doesn't
> make any sense.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->dbclk);
>> @@ -2179,14 +2164,14 @@ static int omap_hsmmc_resume(struct device *=
dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_resume_host(host->mmc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->suspended =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: TODO move put_sync to proper dev=
_pm_ops function */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(host->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(host->dev);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>>
>> -clk_en_err:
>> - =A0 =A0 dev_dbg(mmc_dev(host->mmc),
>> - =A0 =A0 =A0 =A0 =A0 =A0 "Failed to enable MMC clocks during resume=
\n");
>> - =A0 =A0 return ret;
>> =A0}
>>
>> =A0#else
>> @@ -2194,9 +2179,35 @@ clk_en_err:
>> =A0#define omap_hsmmc_resume =A0 =A0 =A0 =A0 =A0 =A0NULL
>> =A0#endif
>>
>> +static int omap_hsmmc_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_hsmmc_host *host;
>> +
>> +
>
> extra blank line

Removed

>
>> + =A0 =A0 host =3D platform_get_drvdata(to_platform_device(dev));
>> + =A0 =A0 omap_hsmmc_context_save(host);
>> + =A0 =A0 dev_dbg(mmc_dev(host->mmc), "disabled\n");
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_hsmmc_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_hsmmc_host *host;
>> +
>> +
>
> extra blank line

Removed

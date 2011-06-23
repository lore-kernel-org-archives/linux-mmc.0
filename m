From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Thu, 23 Jun 2011 07:50:02 -0700
Message-ID: <87boxod2lh.fsf@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<874o3hr9tc.fsf@ti.com>
	<BANLkTi=WnsoETEooK6gsL7jgxf8vuRN97Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [74.125.149.146] ([74.125.149.146]:54811 "EHLO psmtp.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755342Ab1FWO5Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2011 10:57:24 -0400
In-Reply-To: <BANLkTi=WnsoETEooK6gsL7jgxf8vuRN97Q@mail.gmail.com>
	(T. Krishnamoorthy's message of "Thu, 23 Jun 2011 18:01:40 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com

"T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:

> On Thu, Jun 23, 2011 at 12:08 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Balaji T K <balajitk@ti.com> writes:
>>
>
>>> @@ -1880,18 +1873,12 @@ static int __init omap_hsmmc_probe(struct p=
latform_device *pdev)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 mmc->caps |=3D MMC_CAP_DISABLE;
>>>
>>> - =C2=A0 =C2=A0 if (clk_enable(host->iclk) !=3D 0) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->iclk);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->fclk);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err1;
>>> - =C2=A0 =C2=A0 }
>>> -
>>> - =C2=A0 =C2=A0 if (mmc_host_enable(host->mmc) !=3D 0) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(host->iclk)=
;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->iclk);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->fclk);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err1;
>>> - =C2=A0 =C2=A0 }
>>> + =C2=A0 =C2=A0 pm_runtime_enable(host->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_allow(host->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_get_sync(host->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_set_autosuspend_delay(host->dev, MMC_AUT=
OSUSPEND_DELAY);
>>> + =C2=A0 =C2=A0 pm_runtime_use_autosuspend(host->dev);
>>> + =C2=A0 =C2=A0 pm_suspend_ignore_children(host->dev, 1);
>>
>> Why is ignore_children needed for this device? =C2=A0 Is this device=
 the
>> parent of other devices? =C2=A0 If it is, why should it ignore it's
>> children?
>>
>
> No, I will remove. Added it for testing only.
>
>>> =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap2430()) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->dbclk =3D cl=
k_get(&pdev->dev, "mmchsdb_fck");
>>> @@ -2018,6 +2005,8 @@ static int __init omap_hsmmc_probe(struct pla=
tform_device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> =C2=A0 =C2=A0 =C2=A0 omap_hsmmc_debugfs(mmc);
>>> + =C2=A0 =C2=A0 pm_runtime_mark_last_busy(host->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_put_autosuspend(host->dev);
>>>
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>>
>>> @@ -2033,8 +2022,8 @@ err_reg:
>>> =C2=A0err_irq_cd_init:
>>> =C2=A0 =C2=A0 =C2=A0 free_irq(host->irq, host);
>>> =C2=A0err_irq:
>>> - =C2=A0 =C2=A0 mmc_host_disable(host->mmc);
>>> - =C2=A0 =C2=A0 clk_disable(host->iclk);
>>> + =C2=A0 =C2=A0 pm_runtime_mark_last_busy(host->dev);
>>> + =C2=A0 =C2=A0 pm_runtime_put_autosuspend(host->dev);
>>> =C2=A0 =C2=A0 =C2=A0 clk_put(host->fclk);
>>> =C2=A0 =C2=A0 =C2=A0 clk_put(host->iclk);
>>> =C2=A0 =C2=A0 =C2=A0 if (host->got_dbclk) {
>>> @@ -2058,7 +2047,7 @@ static int omap_hsmmc_remove(struct platform_=
device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 struct resource *res;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 if (host) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_host_enable(host->m=
mc);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(hos=
t->dev);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_remove_host(ho=
st->mmc);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->use_reg)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_hsmmc_reg_put(host);
>>> @@ -2069,8 +2058,9 @@ static int omap_hsmmc_remove(struct platform_=
device *pdev)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free_irq(mmc_slot(host).card_detect_irq, host);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_work_sync(&h=
ost->mmc_carddetect_work);
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_host_disable(host->=
mmc);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(host->iclk)=
;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_put_sync(hos=
t->dev);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_forbid(host-=
>dev);
>>
>> Why?
>>
>
> Added for balancing pm_runtime_allow added in  _probe.
> But forbid also resume the device on remove.
> Should this be removed, keeping _allow in _probe ?

Neither the _allow or _forbid are needed,   _enable and _disable are en=
ough.

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_disable(host=
->dev);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->fclk=
);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(host->iclk=
);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host->got_dbcl=
k) {
>>> @@ -2102,6 +2092,8 @@ static int omap_hsmmc_suspend(struct device *=
dev)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 if (host) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: TODO move get=
_sync to proper dev_pm_ops function */
>>
>> what does this mean?
>
> get_sync is needed to enable clock before accessing the registers but
> the discusssion @
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50819.html
> suggested to move runtime get_sync calls to .prepare
> Haven't tried it yet.

The _get is fine here, it's the _put that may be the problem.

Based on that thread you mentioned, it is the using of _put and
_put_sync in the suspend path that is the problem.  Basically, use of
runtime PM calls in the suspend/resume path is not recommended and not
guaranteed to work.   It currently works on OMAP, but I may have to
change this.

=46or now, what is certain is that runtime PM calls in the suspend
callbacks must be the _sync versions.  I'm still working on how to
properly implement the PM domain part for OMAP to correctly implement
the restrictions that the linux-pm maintainers want to enforce.

Kevin

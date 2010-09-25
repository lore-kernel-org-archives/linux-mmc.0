From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Sat, 25 Sep 2010 17:21:52 +0900
Message-ID: <AANLkTi=HWUy7Fm7mKPGWT4m0kzKJhEUE8C=Yw2NN1Z5J@mail.gmail.com>
References: <4C91BD5A.1040804@samsung.com>
	<20100917134031.GA11462@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55289 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0IYIVy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Sep 2010 04:21:54 -0400
Received: by fxm3 with SMTP id 3so1117410fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 25 Sep 2010 01:21:52 -0700 (PDT)
In-Reply-To: <20100917134031.GA11462@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>

2010/9/17 Matt Fleming <matt@console-pimps.org>:
> On Thu, Sep 16, 2010 at 03:46:50PM +0900, Jaehoon Chung wrote:
>> Hi all,
>> =A0 This is a RFC patch that support clock-gating for saving power c=
onsumption.
>> =A0 I found mmc_host_enable/mmc_host_disable function in core.c
>> =A0 (using MMC_CAP_DSIABLE. i think that use when host enable/disabl=
e)
>> =A0 So, i used that functions and implemented some functions in sdhc=
i-s3c.c & sdhci.c
>>
>> i want any feedback. how do you think about this patch?
>> Plz let me know...
>>
>> Thank you all
>>
>> =A0Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> ---
>> =A0drivers/mmc/host/sdhci-s3c.c | =A0 36 +++++++++++++++++++++++++++=
+++++++++
>> =A0drivers/mmc/host/sdhci.c =A0 =A0 | =A0 30 +++++++++++++++++++++++=
+++++++
>> =A0drivers/mmc/host/sdhci.h =A0 =A0 | =A0 =A04 ++++
>> =A03 files changed, 70 insertions(+), 0 deletions(-)
>
> [...]
>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 401527d..fa2e55d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1245,7 +1245,37 @@ out:
>> =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>> =A0}
>>
>> +static int sdhci_enable_clk(struct mmc_host *mmc)
>> +{
>> + =A0 =A0 struct sdhci_host *host =3D mmc_priv(mmc);
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (host->old_clock !=3D 0 && host->clock =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->enable(=
host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, host->old_clock);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int sdhci_disable_clk(struct mmc_host *mmc, int lazy)
>> +{
>> + =A0 =A0 struct sdhci_host *host =3D mmc_priv(mmc);
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (host->clock !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->old_clock =3D host->clock;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->disable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->ops->disable=
(host, lazy);
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0static const struct mmc_host_ops sdhci_ops =3D {
>> + =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D sdhci_enable_clk,
>> + =A0 =A0 .disable =A0 =A0 =A0 =A0=3D sdhci_disable_clk,
>> =A0 =A0 =A0 .request =A0 =A0 =A0 =A0=3D sdhci_request,
>> =A0 =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D sdhci_set_ios,
>> =A0 =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D sdhci_get_ro,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index d316bc7..0c6f143 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -278,6 +278,8 @@ struct sdhci_host {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0timeout_clk; =A0 =A0=
/* Timeout freq (KHz) */
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clock; =A0 =A0 =A0 =A0=
 =A0/* Current clock (MHz) */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0old_clock; =A0 =A0 =A0=
/* Old clock (MHz) */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_cnt; =A0 =A0 =A0 =A0=
/* Clock user count */
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwr; =A0 =A0=
 =A0 =A0 =A0 =A0/* Current voltage */
>>
>> =A0 =A0 =A0 struct mmc_request =A0 =A0 =A0*mrq; =A0 =A0 =A0 =A0 =A0 =
/* Current request */
>> @@ -323,6 +325,8 @@ struct sdhci_ops {
>> =A0 =A0 =A0 unsigned int =A0 =A0(*get_max_clock)(struct sdhci_host *=
host);
>> =A0 =A0 =A0 unsigned int =A0 =A0(*get_min_clock)(struct sdhci_host *=
host);
>> =A0 =A0 =A0 unsigned int =A0 =A0(*get_timeout_clock)(struct sdhci_ho=
st *host);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*enable)(struct sdhci_host *h=
ost);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*disable)(struct sdhci_host *=
host, int lazy);
>> =A0};
>>
>> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>
> I could have misunderstood something, but do you really need this new
> 'old_clock' member? Is the previous clock value not stored in
> host->ios.clock?

Thanks Matt for your comment.
if host->ios.clock set zero, i think that need previous value (for
example 52MHz..)
So i add 'old_clock' member...i will test, after removed 'old_clock'

anyother doubt? and problem?
Thanks

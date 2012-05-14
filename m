From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc4.5: host: poweroff notify rework
Date: Mon, 14 May 2012 14:30:48 +0530
Message-ID: <CAGxe1ZFbOhVa_k4uKg7BqdwcLZAM8An7YpfbirZiJE2cA0092A@mail.gmail.com>
References: <1336398084-23203-1-git-send-email-girish.shivananjappa@linaro.org>
	<1336398084-23203-2-git-send-email-girish.shivananjappa@linaro.org>
	<4FB0B245.7000206@stericsson.com>
	<CAGxe1ZHMWkUUQ1mpgXPi4wxDZHDOF7_-aAa4aeZUqByBrrQxXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56162 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2ENJAs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 05:00:48 -0400
Received: by qcro28 with SMTP id o28so3139612qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 02:00:48 -0700 (PDT)
In-Reply-To: <CAGxe1ZHMWkUUQ1mpgXPi4wxDZHDOF7_-aAa4aeZUqByBrrQxXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>

On 14 May 2012 14:26, Girish K S <girish.shivananjappa@linaro.org> wrot=
e:
> On 14 May 2012 12:50, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>> Hi Girish,
>>
>> In patch 1/2 you break the compilation of these host drivers. In thi=
s patch
>> 2/2 you fix it again. I would prefer you include these fixes in the =
same
>> patch instead of splitting them into two pieces.
> It is a patch series. I have no issue in making it as a single patch.
I will make the changes affecting the host as a separate patch.
>>
>> Kind regards
>> Ulf Hansson
>>
>>
>> On 05/07/2012 03:41 PM, Girish K S wrote:
>>>
>>> This patch changes the structure member name to maintain consistenc=
y
>>> of name for the poweroff notify feature
>>>
>>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>>> ---
>>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
>>> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A04 ++--
>>> =A02 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index ab3fc46..09ac734 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1791,9 +1791,9 @@ static int __init dw_mci_init_slot(struct dw_=
mci
>>> *host, unsigned int id)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED =
| MMC_CAP_MMC_HIGHSPEED;
>>>
>>> =A0 =A0 =A0 =A0if (mmc->caps2& =A0MMC_CAP2_POWEROFF_NOTIFY)
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->poweroff_notify_type =3D MMC_HOS=
T_PW_OFF_NOTIFY_SHORT;
>>> =A0 =A0 =A0 =A0else
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_NONE;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->poweroff_notify_type =3D MMC_HOS=
T_PW_OFF_NOTIFY_NONE;
>>>
>>> =A0 =A0 =A0 =A0if (host->pdata->blk_settings) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->pdata->blk_s=
ettings->max_segs;
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index e626732..958e5fe 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2817,9 +2817,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 =A0 * set notify to short power off notify timeout valu=
e.
>>> =A0 =A0 =A0 =A0 */
>>> =A0 =A0 =A0 =A0if (mmc->caps2& =A0MMC_CAP2_POWEROFF_NOTIFY)
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->poweroff_notify_type =3D MMC_HOS=
T_PW_OFF_NOTIFY_SHORT;
>>> =A0 =A0 =A0 =A0else
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_NONE;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->poweroff_notify_type =3D MMC_HOS=
T_PW_OFF_NOTIFY_NONE;
>>>
>>> =A0 =A0 =A0 =A0/* Initial value for re-tuning timer count */
>>> =A0 =A0 =A0 =A0host->tuning_count =3D (caps[1]& =A0SDHCI_RETUNING_T=
IMER_COUNT_MASK)>>
>>
>>

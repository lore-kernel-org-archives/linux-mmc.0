From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v4 03/12] omap_hsmmc: add support for pre_req and post_req
Date: Fri, 17 Jun 2011 12:15:55 +0200
Message-ID: <BANLkTikk14y_tweX45JdDb+qqYtOTuMnbg@mail.gmail.com>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
	<1306360653-6196-4-git-send-email-per.forlin@linaro.org>
	<BANLkTikP8pveKPPG+_h6_hBenh91vAi4mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTikP8pveKPPG+_h6_hBenh91vAi4mQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-dev <linaro-dev@lists.linaro.org>, David Vrabel <david.vrabel@csr.com>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2011 15:14, S, Venkatraman <svenkatr@ti.com> wrote:
> On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> pre_req() runs dma_map_sg(), post_req() runs dma_unmap_sg.
>> If not calling pre_req() before omap_hsmmc_request()
>> dma_map_sg will be issued before starting the transfer.
>> It is optional to use pre_req(). If issuing pre_req()
>> post_req() must be to be called as well.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 87 ++++++++++++++++++++++++++=
+++++++++++++--
>> =A01 files changed, 83 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index ad3731a..2116c09 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -141,6 +141,11 @@
>> =A0#define OMAP_HSMMC_WRITE(base, reg, val) \
>> =A0 =A0 =A0 =A0__raw_writel((val), (base) + OMAP_HSMMC_##reg)
>>
>> +struct omap_hsmmc_next {
>> + =A0 =A0 =A0 unsigned int =A0 =A0dma_len;
>> + =A0 =A0 =A0 s32 =A0 =A0 =A0 =A0 =A0 =A0 cookie;
>> +};
>> +
>> =A0struct omap_hsmmc_host {
>> =A0 =A0 =A0 =A0struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
>> =A0 =A0 =A0 =A0struct =A0mmc_host =A0 =A0 =A0 =A0*mmc;
>> @@ -184,6 +189,7 @@ struct omap_hsmmc_host {
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_bloc=
ked;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_reg;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_in_pr=
ogress;
>> + =A0 =A0 =A0 struct omap_hsmmc_next =A0next_data;
>>
>> =A0 =A0 =A0 =A0struct =A0omap_mmc_platform_data =A0*pdata;
>> =A0};
>> @@ -1344,8 +1350,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_=
status, void *cb_data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_le=
n,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(host, data));
>> + =A0 =A0 =A0 if (!data->host_cookie)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data-=
>sg, data->sg_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_=
get_dma_dir(host, data));
>>
>> =A0 =A0 =A0 =A0req_in_progress =3D host->req_in_progress;
>> =A0 =A0 =A0 =A0dma_ch =3D host->dma_ch;
>> @@ -1363,6 +1370,45 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch=
_status, void *cb_data)
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> +static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mmc_data *data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_hsmmc_next *next)
>> +{
>
> As you are passing &host->next_data into next, next will always be a
> valid pointer. So..
>
omap_hsmmc_pre_dma_transfer() is called from two places. in pre_req()
and start_dma_transfer().
next is NULL if called from start_dma_transfer.

/Per

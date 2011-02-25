From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v4 5/6] OMAP: adapt hsmmc to hwmod framework
Date: Fri, 25 Feb 2011 18:58:01 +0530
Message-ID: <AANLkTimK2R0=01BKj2p11Y3Q6Za9LtV0yV_Tkn1CtTJL@mail.gmail.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
 <1298575614-9388-6-git-send-email-kishore.kadiyala@ti.com> <AANLkTikfa5BPUvbRtc12j3=TvW0HG47kT9JET13Kuiud@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44202 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755669Ab1BYN2X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 08:28:23 -0500
In-Reply-To: <AANLkTikfa5BPUvbRtc12j3=TvW0HG47kT9JET13Kuiud@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com

On Fri, Feb 25, 2011 at 6:20 PM, Krishnamoorthy, Balaji T
<balajitk@ti.com> wrote:
> <snip>
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->reg_offset =3D OM=
AP4_MMC_REG_OFFSET;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->reg_offset =3D 0;
>> +static struct omap_mmc_platform_data *mmc __initdata;
>
> can you pass this *mmc as another argument to omap_hsmmc_pdata_init
> so that this static initdata can be removed ?

Agree, will go with as said

>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->get_context_loss_count =3D hsmmc_=
get_context_loss;
>> +static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c)
>> +{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *hc_name;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].switch_pin =3D c->gpio_c=
d;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].gpio_wp =3D c->gpio_wp;
>> + =A0 =A0 =A0 if (!c->mmc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("MMC%d: no such controller\n"=
, c->mmc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].remux =3D c->remux;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].init_card =3D c->init_ca=
rd;
>> + =A0 =A0 =A0 hc_name =3D kzalloc(sizeof(char) * (HSMMC_NAME_LEN + 1=
), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!hc_name) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot allocate memory for con=
troller slot name\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hc_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c->cover_only)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].cover =3D=
 1;
>> + =A0 =A0 =A0 if (c->name)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(hc_name, c->name, HSMMC_NAME_L=
EN);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(hc_name, (HSMMC_NAME_LEN + 1)=
, "mmc%islot%i",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->mmc, 1);
>> + =A0 =A0 =A0 mmc->slots[0].name =3D hc_name;
>> + =A0 =A0 =A0 mmc->nr_slots =3D 1;
>
> <snip>
>

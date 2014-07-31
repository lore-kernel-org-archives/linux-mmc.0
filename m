From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=
	<cm-hiep@jinso.co.jp>
Subject: Re: [PATCH 0/10 v2] mmc: tmio: fixup patches
Date: Thu, 31 Jul 2014 14:05:19 +0900
Message-ID: <53D9CE8F.1030102@jinso.co.jp>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>	<53AD638C.5060907@renesas.com>	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>	<87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>	<53D9A148.1000802@jinso.co.jp>	<20140731023037.GC2558@verge.net.au>	<53D9C5A3.8090908@jinso.co.jp> <87k36uuoxq.wl%kuninori.morimoto.gx@gmail.com>
Reply-To: cm-hiep@jinso.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87k36uuoxq.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, "(Renesas)goda" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, ryo.kataoka.wt@renesas.com, shinobu.uehara.xc@renesas.com, kouei.abe.cp@renesas.com
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On 07/31/2014 01:34 PM, Kuninori Morimoto wrote:
> Hi
>
>>>>> These are v2 of fixup patches for mmc tmio/shmobile.
>>>>> I tesed these patches on my environment.
>>>>> I'm very happy if someone test these patches.
>>>> I have just tested these series on Lager. if remove CONFIG_HIGHMEM from
>>>> config file,
>>>> They are good at SDHI and MMC on my environment.
>>> Could you provided a Tested-by tag?
>> Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
>> Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> I guess, both "Tested-by" is correct :)
>
>    Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
>    Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>
> # "Reported-by" means "bug report", not "test report"
Thanks for pointing it.
Simon-san, Could you please do as Morimoto-san pointed?

Best regards,
Cao Minh Hiep.

> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


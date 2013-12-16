From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 16 Dec 2013 13:21:52 +0100
Message-ID: <52AEF060.6000405@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <2378731.6b9MyH8v8A@dizzy-6.site> <52AE0E87.2040304@redhat.com> <1743952.noztKtcF2Y@dizzy-6.site>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB2PAXOKQKGQEWF4KAQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1743952.noztKtcF2Y-GPtPHOohwlnjSbz6xCtQhw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/15/2013 10:19 PM, David Lanzend=F6rfer wrote:
>>> [...]
>>> Do you have something like this in mind? ->
>>> drivers/mmc/host/dw_mmc-exynos.c
>> No, as explained in my previous mail the idmac being shared seemed to be=
 the
>> only 2 things the dw-mmc controller and the sunxi-mmc controller have in
>> common.
> Ok.
>
>> Looking at dw_mmc-exynos.c it still pretty much is the classic dw-mmc
>> controller with some extra bits, where as the sunxi controller is
>> significantly different (which allows us to write a significant simpler
>> driver).
> Do you have an outline for such a driver as you imagine it?
> I'd be interested into some "experiments".
> Maybe you have a repository where you could push a dedicated tree
> for some colaboration on this?

I think that we're miss-communicating a bit here. What I'm trying to say
is that trying to extend the dw_mmc driver to support sunxi is a bad
idea because the sunxi hardware is quite different. And that the
sunxi hardware having autostop allows the existing sunxi-mci driver to
be much simpler then the dw-mmc driver.

IOW the much simpler driver already exists and it is the sunxi-mci
driver.

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

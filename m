From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 15 Dec 2013 21:18:15 +0100
Message-ID: <52AE0E87.2040304@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <20131215162109.GI3651@lukather> <52ADF7D8.2010900@redhat.com> <2378731.6b9MyH8v8A@dizzy-6.site>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBEE5XCKQKGQENJ5OJUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <2378731.6b9MyH8v8A-GPtPHOohwlnjSbz6xCtQhw@public.gmane.org>
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

On 12/15/2013 08:35 PM, David Lanzend=F6rfer wrote:
> Hi
>
>>>>>> [...]
>>>>>> +	mmc->f_max		=3D 50000000;
>>>>>> [...]
>>>> [...]
>>>> in case of sdc3 they are putting 200000000 in f_max (as that is often
>>>> used for sdio cards) but then later in set_ios they clamp the passed
>>>> in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actuall=
y
>>>> worked. Hence I've simply gone for a safe range for now. If someone ha=
s
>>>> cards capable of doing 200 MHz we could certainly run various tests an=
d
>>>> try to improve this, but for now this seems a sane range to start with=
.
>>> That's probably something that you should mention in your comment then =
:)
>> Good point, David ?
> Yes.
> a) We should mention any reason why we did what.
> b) If there is room for optimization we should mention that as well since=
:
> 	i) we won't remember every single detail in half a year
> 	ii) someone else might need to follow our considerations
>
>> Right, my bad, sorry. I was so happy I was finally ready to send the pat=
ch
>> upstream (I finally had fixed everything on my todo list), I rushed the
>> cover letter a bit. I was planning on putting things like this in there,
>> as well as why we didn't try to extend the mmc-dw driver, but I forgot.
> Do you have something like this in mind? -> drivers/mmc/host/dw_mmc-exyno=
s.c

No, as explained in my previous mail the idmac being shared seemed to be th=
e
only 2 things the dw-mmc controller and the sunxi-mmc controller have in co=
mmon.

Looking at dw_mmc-exynos.c it still pretty much is the classic dw-mmc contr=
oller
with some extra bits, where as the sunxi controller is significantly differ=
ent
(which allows us to write a significant simpler driver).

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

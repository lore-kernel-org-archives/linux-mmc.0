From: "Arend van Spriel" <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: mwifiex_sdio on chromebook
Date: Tue, 5 Nov 2013 09:53:00 +0100
Message-ID: <5278B1EC.8020000@broadcom.com>
References: <5276491F.20207@mail.ru>
 <477F20668A386D41ADCC57781B1F70430F45757E63@SC-VEXCH1.marvell.com>
 <527703E6.8040504@mail.ru>
 <477F20668A386D41ADCC57781B1F70430F45758053@SC-VEXCH1.marvell.com>
 <5278AE8E.9060203@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5278AE8E.9060203-JGs/UdohzUI@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Varnin <fenixk19-JGs/UdohzUI@public.gmane.org>, Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 11/05/2013 09:38 AM, Alexander Varnin wrote:
> 04.11.2013 23:46, Bing Zhao =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi Alexander,
>>
>>>> Your Chromebook supports SDIO high speed mode (SDIO 2.0 spec). So
>>>> 50MHz is correct.
>>> Ok, but mainline kernel doesn't try this frequency. It tries 400kHz=
 at
>>> most.
>>>
>>>> What are you trying to do here? Are you trying to run a mainline k=
ernel on your Chromebook?
>>> Yes. I've got kernel 3.4 from Google Chrome OS. It works ok for
>>> mwifiex_sdio. But I want to run mainline kernel. As of 3.11 it is a=
ble
>>> to boot on Chromebook, but WiFi doesn't work.
>> I don't know why you want to do that, but the mainline kernel won't =
work on your Chromebook unless you port all platform specific changes o=
ver from chromeos-3.4 tree.
>>
>>>> You said mmc_attach_sdio function fails. The mwifiex_sdio driver a=
nd
>>>> the firmware will not be loaded at all.
>>> Ok, that is clear.
>>>
>>>> CONFIG_MMC_DEBUG=3Dy, and collect the debug logs.
>>> This way seems not very useful, because there is also internal and
>>> external storage on mmc bus, so log quickly get garbaged with it. D=
mesg
>>> seems to be overflowed and forgets early initialization. I have mad=
e a
>>> dirty hack to collect some useful info about initialization. I am
>>> attaching it. Please check, if I need to add something. Will it be
>>> useful this way?
>> As said above, this won=E2=80=99t work because the Chromebook specif=
ic changes aren't present in mainline kernel. Anyway you can take a loo=
k at the chromium OS developer guide.
>>
>> http://www.chromium.org/chromium-os/developer-guide
>>
>> Thanks,
>> Bing
>>
>
> It is ported at most already and mainline kernel works good on
> Chromebook. It is just peripheral problem.

Not sure how chromium os architecture looks like, but you mean to say=20
*you* ported code in chromium user-space to work with upstream/mainline=
=20
kernel API's?

Regards,
Arend

> --
> To unsubscribe from this list: send the line "unsubscribe linux-wirel=
ess" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alexander Varnin <fenixk19-JGs/UdohzUI@public.gmane.org>
Subject: Re: mwifiex_sdio on chromebook
Date: Tue, 05 Nov 2013 13:12:46 +0400
Message-ID: <5278B68E.5070807@mail.ru>
References: <5276491F.20207@mail.ru> <477F20668A386D41ADCC57781B1F70430F45757E63@SC-VEXCH1.marvell.com> <527703E6.8040504@mail.ru> <477F20668A386D41ADCC57781B1F70430F45758053@SC-VEXCH1.marvell.com> <5278AE8E.9060203@mail.ru> <5278B1EC.8020000@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5278B1EC.8020000-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

05.11.2013 12:53, Arend van Spriel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>
>> It is ported at most already and mainline kernel works good on
>> Chromebook. It is just peripheral problem.
>
> Not sure how chromium os architecture looks like, but you mean to say
> *you* ported code in chromium user-space to work with
> upstream/mainline kernel API's?=20

No. There is work doing by somebody from google or somewhere else, by
making mainline kernel work on Chromebook. Kernel 3.11 is the first
mainline kernel, that is able to boot and work on Chromebook. Working
parts is MMC controller, display controller, keyboard, etc. Not working
is usb, wifi, rtc, temperature sensors, etc.

By a tradition of open source, as I am interested, and I have experienc=
e
in kernel development, I have decided to debug wifi issue by myself. I
don't know, why I should port anything. Everything that was needed is
already ported - there is Chromebook device tree in kernel, there is al=
l
required drivers. There is just a problem with powering up Marvell wifi
chip. I don't see, why fixing it requires any complex porting.

One thing worth doing is to compare 3.4 from chromeos and 3.4 mainline,
and find, if there any specific wifi changes. But there is possibly not=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

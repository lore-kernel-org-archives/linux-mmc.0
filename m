From: Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] brcmfmac: Add support for bcm43364 wireless chipset
Date: Tue, 8 May 2018 14:11:38 +0200
Message-ID: <5AF193FA.7000700@broadcom.com>
References: <1525416503-832-1-git-send-email-sean@lano.id.au>
 <CAPDyKFr62-+EF_GRbUSa=VOQfYa3c3HHZCR_LsN67k1yVkNNFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFr62-+EF_GRbUSa=VOQfYa3c3HHZCR_LsN67k1yVkNNFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
Cc: Franky Lin <franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hante Meuleman <hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

+ Kalle (explicitly)

On 5/8/2018 9:58 AM, Ulf Hansson wrote:
> On 4 May 2018 at 08:48, Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org> wrote:
>> Add support for the BCM43364 chipset via an SDIO interface, as used in
>> e.g. the Murata 1FX module.
>>
>> The BCM43364 uses the same firmware as the BCM43430 (which is already
>> included), the only difference is the omission of Bluetooth.
>>
>> However, the SDIO_ID for the BCM43364 is 02D0:A9A4, giving it a MODALIAS
>> of sdio:c00v02D0dA9A4, which doesn't get recognised and hence doesn't
>> load the brcmfmac module. Adding the 'A9A4' ID in the appropriate place
>> triggers the brcmfmac driver to load, and then correctly use the
>> firmware file 'brcmfmac43430-sdio.bin'.
>>
>>
>> Signed-off-by: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
>
> Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Arend, I assume you want to pick this up? If not, just tell and I can do it.

Not necessarily. I let Kalle do the leg work ;-) Given the change I do 
not expect any conflict so we can go either way with a slight preference 
for wl-drivers-next. Kalle?

Regards,
Arend

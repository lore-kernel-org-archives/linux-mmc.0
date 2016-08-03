From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] MMC: meson: inital support for GXBB platforms
Date: Wed, 3 Aug 2016 08:27:48 -0700
Message-ID: <CAOi56cXq2Vqz+7xT1J7NO01cV7HwMt=U-_7NPwEFf1D01R2VXQ@mail.gmail.com>
References: <20160803003045.24980-1-khilman@baylibre.com> <CGME20160803003156epcas1p2473ed7677a97642c892baefa5dcffddd@epcas1p2.samsung.com>
 <20160803003045.24980-2-khilman@baylibre.com> <57A13CB5.4000006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57A13CB5.4000006-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 2, 2016 at 5:37 PM, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Kevin,
>
> On 08/03/2016 09:30 AM, Kevin Hilman wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GXBB
>> family of SoCs.
>>
>> Currently working for the SD and eMMC interfaces, but not yet tested for
>> SDIO.
>>
>> Tested external SD card and internal eMMC on meson-gxbb-p200 and
>> meson-gxbb-odroidc2.
>
> Before sending patch, run the checkpatch.pl for your patch.

Yes, sorry about that.  This patch was sent prematurely.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] mmc: sunxi: Make sample clocks optional
Date: Sat, 30 Jul 2016 16:25:40 +0200
Message-ID: <abe8e074-e58f-78c3-64d2-4f7870a58c28@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
 <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
 <20160725081830.GF7419@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160725081830.GF7419@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 25-07-16 10:18, Maxime Ripard wrote:
> Hi,
>
> On Sat, Jul 16, 2016 at 12:46:02PM +0200, Hans de Goede wrote:
>> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
>> clocks, so make them optional.
>>
>> Since these do not have sample clocks, they cannot (reliably) do
>> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
>>
>> Note this patch only changes the devm_clk_get error checking and sets
>> the clocks to NULL if they don't exists. All the clk_foo calls accept
>> a NULL clk and will return success when called with a NULL clk, so this
>> is all that is necessary.
>
> The clocks aren't really optional. They're not needed for the A10 /
> A13, and mandatory for the A20 and later.
>
> Having a new compatible for the A20 that would require that clock and
> not require it for the A10/A13 anymore seems more appropriate.

Ok, I've prepared a new version using a new compatible.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

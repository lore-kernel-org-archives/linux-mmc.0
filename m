From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/2] mmc: dw_mmc: Add the ability to set the ciu clock
 frequency
Date: Thu, 20 Jun 2013 10:52:09 +0900
Message-ID: <51C26049.10703@samsung.com>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
 <1370626110-1731-1-git-send-email-dianders@chromium.org>
 <1370626110-1731-2-git-send-email-dianders@chromium.org>
 <51BFE754.6000909@samsung.com>
 <CAD=FV=Wy5X9C=NOUVyAzZK5+BKD1w4FTmoTHzKipq2j_Y9rdtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16183 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935237Ab3FTBwF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2013 21:52:05 -0400
In-reply-to: <CAD=FV=Wy5X9C=NOUVyAzZK5+BKD1w4FTmoTHzKipq2j_Y9rdtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Andrew Bresticker <abrestic@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Will Newton <will.newton@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>

Hi Doug,

I'm researching for fixed-rate-clocks.
Maybe i misunderstood for using <fixed-rate-clocks>. :)

Best Regards,
Jaehoon Chung

On 06/19/2013 12:15 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Mon, Jun 17, 2013 at 9:51 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Doug,
>>
>> I have one question for using <clock-frequency>.
>> I found the fixed-rate-clocks feature.
>> If we want to set <clock-frequency>, then can we use the fixed-rate-clocks?
>> i'm not sure how use the fixed-rate-clocks. but it seems to set fixed-rate value for clock frequency.
>>
>> clk_set_rate() didn't ensure to set the <clock-frequency> value.
> 
> I'm not sure I understand the question.  I don't think that the
> fixed-rate-clocks have a close relation to the clock-frequency or the
> ciu clock.  The fixed-rate-clock entries for a board usually specify
> the root clock source for a board.  For instance in exynos5250-snow
> you can see:
> 
> fixed-rate-clocks {
>   xxti {
>     compatible = "samsung,clock-xxti";
>     clock-frequency = <24000000>;
>   };
> };
> 
> Other clocks in the board are derived from this clock through PLLs,
> muxes, dividers, gates, etc.  On 5250 we have:
> 
>  fin_pll (xxti) -> fout_mpll -> fout_mplldiv2 -> mout_mpll_fout ->
>  sclk_mpll -> sclk_mpll_user -> mout_mmc1 -> div_mmc1
>  div_mmc_pre1 -> sclk_mmc1
> 
> In 5250 the ciu clock for mmc1 is sclk_mmc1, which is a simple gate.
> When you "enable" this clock it, ungates it.  The sclk_mmc1 has the
> flag CLK_SET_RATE_PARENT on it.  That means when you try to set the
> rate it will involve the parent clock (div_mmc_pre1).  The parent
> clock also has CLK_SET_RATE_PARENT, so it can also involve div_mmc1.
> I haven't dug through to see how the clock framework splits up divides
> between div_mmc1 and div_mmc_pre1, but it's supposed to handle that.
> 
> We don't allow clk_set_rate to percolate any higher (no
> CLK_SET_RATE_PARENT at mout_mmc1).
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


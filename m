From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add
 rockchip,default-drv-phase
Date: Wed, 11 May 2016 16:25:33 +0800
Message-ID: <2994d365-2cf2-0990-6c10-2abeebb42eef@rock-chips.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
 <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
 <b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
 <CAD=FV=XToSzqSh=SShHuQU9W_m7gfyQn8wRXkLy79t+tnqZknA@mail.gmail.com>
 <1f2f43c7-2672-e448-eddb-2d613bb8dc48@rock-chips.com>
 <CAD=FV=UGbrJRyUbbgzbcYf9GjPG+Fh_gpQ3rX2G=wi2w5Lw=Sg@mail.gmail.com>
 <e202f663-88d7-693b-a765-c130e68d1c2d@rock-chips.com>
 <CAD=FV=UyYCqMYKScjVEASrbzO75014kPCEt39uOSTsgq9M==YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:40810 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbcEKI0K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2016 04:26:10 -0400
In-Reply-To: <CAD=FV=UyYCqMYKScjVEASrbzO75014kPCEt39uOSTsgq9M==YQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2016/5/11 11:50, Doug Anderson wrote:
> Hi,
>
> On Tue, May 10, 2016 at 7:50 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>> maybe. But I think 180(downside) is the better.
>>
>>
>> NAK my previous comments here. Downside is better for SRD, but won't
>> work for DDR mode. When running in DDR mode, we should use 90 instead.
>>
>> So let me elaborate a bit more here.
>> For DDR mode, one single clk cycle should sending two data bits outside
>> to the devices. We need a hold time for both. If 180 is used, the first
>> bit occurs around the downside area, which won't be sampled by devices
>> on the upside.  So on the upside, the devices will see a zero bit if you
>> actually send a one-bit, which makes the devices  generate CRC finally.
>>
>>
>> For this above, 180 for all SDR mode is ok, but 90 should be deployed
>> for DDR mode. So simply checking the timing to hardcode it should be
>> fine.
>
> OK, I sent out a patch for 180 always.  I can send v2 to use 90 for
> DDR modes tomorrow.  ...or feel free to post that yourself if you
> want.
>
> We want 90 for all DDR modes?  So MMC_TIMING_UHS_DDR50,
> MMC_TIMING_MMC_DDR52, MMC_TIMING_MMC_HS400? (not that we support HS400
> in dw_mmc on Rockchip).

Right.

>
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin


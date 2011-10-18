From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 18 Oct 2011 01:47:16 -0400
Message-ID: <m2ehya6ecb.fsf@bob.laptop.org>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
	<4E9D0B9F.1060303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4E9D0B9F.1060303@samsung.com> (Jaehoon Chung's message of "Tue,
	18 Oct 2011 14:16:15 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Oct 18 2011, Jaehoon Chung wrote:
> Hi Girish.
>
> This patch is merged on mmc-next..did you know that?
> And if deleted commit id bd3151f6c55c553bed2c0df72792841457b75bb5,
> I will re-work for eMMC feature4.5.
> git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5
>
> To Chris.
> If you re-commit this patch, i also change "git pull request".
> there are duplicated code in Notify patch, so i didn't add to cache patch.

I think I've fixed everything up -- I merged your pull request, included
Girish's new patch, and moved the #defines for the CACHE_CTRL patch over
to that patch instead of the power class patch.  Would be great if you
can double-check that the merge all looks okay to you.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

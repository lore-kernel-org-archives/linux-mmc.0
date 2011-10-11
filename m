From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND V1] mmc: replace printk with appropriate display macro
Date: Tue, 11 Oct 2011 10:11:26 -0400
Message-ID: <m2y5wrk48h.fsf@bob.laptop.org>
References: <1318313649-22465-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1318313649-22465-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Tue, 11 Oct 2011 11:44:09 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Oct 11 2011, Girish K S wrote:
> All the files using printk function for displaying kernel messages
> in the mmc driver have been replaced with corresponding macro.

Thanks, applied!

I haven't been sure how to handle this patch; in general cosmetic
patches that touch many parts of many files are a bad idea, because they
break the ability to merge patches.  Since we're getting near the end of
merging the 3.2 merge window patches, though, maybe now is a good time.

If this patch starts causing merge conflicts, I might pull it out later
or remove the modifications for the most common files (core.c/sd.c/sdhci.c).

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

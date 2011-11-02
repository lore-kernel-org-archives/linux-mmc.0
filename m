From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V6] SDHCI: S3C: Use generic clock names for sdhci bus clock options
Date: Wed, 02 Nov 2011 13:56:32 -0400
Message-ID: <m2aa8e9zn3.fsf@bob.laptop.org>
References: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
	<005301cc9958$bcf5aa10$36e0fe30$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <005301cc9958$bcf5aa10$36e0fe30$%kim@samsung.com> (Kukjin Kim's
	message of "Wed, 02 Nov 2011 21:12:49 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Rajeshwari Shinde' <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Kukjin,

On Wed, Nov 02 2011, Kukjin Kim wrote:
>> This patch modifies the driver to stop depending on the clock names
>> being passed from the platform and switch over to bus clock lookup
>> using generic clock names.
>> 
>> V6 Changes:
>> Changed sprintf to snprintf as suggested by Chris Ball.
>> 
>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> Hi Chirs,
>
> Could you please pick this up in your tree for this merge window?

Might be easier to have you send this, if you don't mind, since I'm
still traveling and have already sent my main pull request.  Thanks!

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

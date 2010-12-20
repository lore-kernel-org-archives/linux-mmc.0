From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 2/2] sdhci-s3c: Add support no internal clock
	divider in host controller
Date: Mon, 20 Dec 2010 07:06:01 +0000
Message-ID: <20101220070601.GA22742@void.printf.net>
References: <1286776076-24970-1-git-send-email-kgene.kim@samsung.com> <AANLkTinJE0GOFbVEWNdTxwpv2Dwi6im0ipkPsf8jEhU1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinJE0GOFbVEWNdTxwpv2Dwi6im0ipkPsf8jEhU1@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kyungmin, Ben,

On Mon, Dec 20, 2010 at 11:08:00AM +0900, Kyungmin Park wrote:
> Hi Chris,
> 
> Unfortunately it's not merged your tree.
> It's required for s5pc210 board. can you merge it for 37-rc6 or later?

I'm not comfortable slipping this into .37 (-rc6 has already been
released) without an ACK from Ben, but I will accept it into mmc-next
for the .38 merge window, and Ben can yell sometime before the merge
if he doesn't agree.  Does that work okay for you?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

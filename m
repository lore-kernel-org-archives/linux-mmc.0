From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on device id
Date: Tue, 26 Nov 2013 18:33:50 -0500
Message-ID: <87ioveeo0x.fsf@octavius.laptop.org>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-3-git-send-email-tony@atomide.com>
	<20131118184723.GR10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131118184723.GR10317@atomide.com> (Tony Lindgren's message of
	"Mon, 18 Nov 2013 10:47:24 -0800")
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Mon, Nov 18 2013, Tony Lindgren wrote:
> We are wrongly relying on device id for the DMA configuration
> which can lead to wrong DMA channel being selected.
>
> Fix the issue by using the standard resources like we should.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Feel free to merge via your tree:

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] ARM: shmobile: Remove unnecessary MMC options
Date: Thu, 30 Oct 2014 10:03:09 +0900
Message-ID: <20141030010309.GD22052@verge.net.au>
References: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 29, 2014 at 03:09:36PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series, sent before by Morimoto-san, removes unnecessary MMC options
> from the DTS files that are already set automatically by the driver, based on
> the compatible property value. Note that these options were never added on
> r8a7791, which gained SDHI device nodes later than the three affected SoCs.
> 
> Thanks for applying!

Thanks, I have queued these up.

From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] arm64: dts: h3ulcb: enable HS200 for eMMC
Date: Fri, 27 Jan 2017 09:29:35 +0100
Message-ID: <20170127082935.GH21195@verge.net.au>
References: <1485443606-22566-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1485443640-22651-1-git-send-email-vladimir.barinov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485443640-22651-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

[CC Wolfram, linux-mmc]

On Thu, Jan 26, 2017 at 06:14:00PM +0300, Vladimir Barinov wrote:
> From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
> 
> This supports HS200 mode for eMMC on H3ULCB board
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

Hi Vladimir,

Please resend this change once the relevant driver changes hit an rc
release.

I believe that means the following changes which are present in mmc/next.

8c81459fa8ad mmc: sh_mobile_sdhi: enable HS200
60f215caef3f mmc: sh_mobile_sdhi: remove superfluous check in SCC error check
f7c68068fb27 mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
4cf3ecd2e097 mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
bdba200138a9 mmc: sh_mobile_sdhi: improve prerequisites for tuning
a7f2c661cca9 mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
59c21074b582 mmc: sh_mobile_sdhi: simplify accessing DT data

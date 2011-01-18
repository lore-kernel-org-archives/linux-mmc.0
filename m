From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 2/2] msm: 8x50: Add initial support for SDCC
Date: Tue, 18 Jan 2011 12:28:34 -0800
Message-ID: <8yar5cat0r1.fsf@huya.qualcomm.com>
References: <1295329970-26814-1-git-send-email-stummala@codeaurora.org>
	<1295329970-26814-2-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1295329970-26814-2-git-send-email-stummala@codeaurora.org>
	(Sahitya Tummala's message of "Tue, 18 Jan 2011 11:22:50 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: dwalker@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, san@google.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 17 2011, Sahitya Tummala wrote:

> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  arch/arm/mach-msm/board-qsd8x50.c               |   81 +++++++++-
>  arch/arm/mach-msm/devices-qsd8x50.c             |  196 +++++++++++++++++++++++
>  arch/arm/mach-msm/gpiomux-8x50.c                |   23 +++
>  arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |    8 +-
>  4 files changed, 303 insertions(+), 5 deletions(-)

This will have to wait until the msm_sdcc driver itself is cleaned up to
not use the internal dma api calls (and compiles again with the current
kernel).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

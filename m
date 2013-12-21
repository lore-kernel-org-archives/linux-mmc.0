From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 1/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Fri, 20 Dec 2013 16:53:59 -0800
Message-ID: <20131221005359.GI26054@atomide.com>
References: <1387193091-23218-1-git-send-email-afenkart@gmail.com>
 <1387193091-23218-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387193091-23218-2-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [131216 03:29]:
> For now, only support SDIO interrupt if we are booted with
> DT. This is because some platforms need special quirks. And
> we don't want to add new legacy mux platform init code
> callbacks any longer as we are moving to DT based booting
> anyways.
> 
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Acked-by: Tony Lindgren <tony@atomide.com>

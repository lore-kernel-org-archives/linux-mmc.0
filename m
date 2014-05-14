From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 0/6] mmc: omap_hsmmc: Enable SDIO IRQ
Date: Wed, 14 May 2014 12:21:23 +0200
Message-ID: <CAPDyKFqwNYr3WHe+4e5+3gt-NCYiwPq7DxG7HHr+YTygZXPZnw@mail.gmail.com>
References: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 May 2014 13:28, Andreas Fenkart <afenkart@gmail.com> wrote:
> Hi Balaji, Tony, all
>
> v12
> - drop !CONFIG_OF compile break only exists when
>   #undef CONFIG_OF after include headers 1/7(Sebastian Reichel)
> - do not emit "falling back to polling" if wake_irq not specified
>   since MMC does not need it, and it might confuse users
>   only emit if pinmux default/idle is not present or claiming
>   the irq failed 2/7(Balaji)
> - dropped out-of-tree patches 6/7(Balaji)
> - mention "ti,am33xx-hsmmc" compatible section in bindings
>   documentation 1/5

Hi Andreas,

It seems like we are ready to merge this patchset - I will include it
in the next PR I send to Chris.

Kind regards
Ulf Hansson

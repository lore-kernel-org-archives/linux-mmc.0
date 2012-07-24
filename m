From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: Disable low power mode if SDIO interrupts
 are used
Date: Tue, 24 Jul 2012 09:58:23 -0700
Message-ID: <CAD=FV=WeX+TACSR+z7ynmurnSnayGc30_gFRtnek=Mv-c3o3JA@mail.gmail.com>
References: <CAD=FV=XuXUe1Jyd_urCzmS5+1vv7iuNTXYr23XYZp+MnTq1HGg@mail.gmail.com>
	<1343062955-24516-1-git-send-email-dianders@chromium.org>
	<004d01cd693a$0a55d7b0$1f018710$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <004d01cd693a$0a55d7b0$1f018710$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Olof Johansson <olofj@chromium.org>, shashidharh@vayavyalabs.com, ki0351.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 23, 2012 at 6:17 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> I have followed this patch from v1.
> I think it's a good point.
> Looks good to me.

Thanks for the review!  Looking forward to your ack with the next version.  :)

> Above comment is correct, but this is not specific for Exynos5250.
> Exynos5250 is just one of host controllers base on Synopsys's.
> It'd be better to remove the part related to Exynos you mentioned .

Done.  Grant had requested me to quote exactly which manual I found
the requirement in, but I think describing just that it was found in
the description of the CLKENA register is enough.  I've changed it.

> Definitely, low power mode not power mode, right?

Done.  Good catch!


-Doug

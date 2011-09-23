From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 37/55] mmc: irq: Remove IRQF_DISABLED
Date: Fri, 23 Sep 2011 14:55:57 -0400
Message-ID: <m2pqirw0jm.fsf@bob.laptop.org>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
	<1316681962-8217-38-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1316681962-8217-38-git-send-email-yong.zhang0@gmail.com> (Yong
	Zhang's message of "Thu, 22 Sep 2011 16:59:04 +0800")
Sender: linux-arch-owner@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Tony Lindgren <tony@atomide.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Sep 22 2011, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>
> So now this flag is a NOOP and can be removed.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.2 with Kishore's ACK added.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

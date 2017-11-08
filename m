From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 0/9] mtd: sharpslpart partition parser
Date: Wed, 8 Nov 2017 08:54:46 +0100
Message-ID: <20171108085446.718a2ff5@bbrezillon>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
        <20170821221339.70cfcfb7@bbrezillon>
        <87pobmoz8n.fsf@belgarion.home>
        <CAAQYJAv8bNrxJ_ESgC0fOAdry7i5mstzgQ3P74q1D=C-xsJprg@mail.gmail.com>
        <20170824114631.089d2628@bbrezillon>
        <87inh6pw9e.fsf@belgarion.home>
        <87376uezjs.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87376uezjs.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Andrea Adami <andrea.adami@gmail.com>, linux-mtd@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Lee Jones <lee.jones@linaro.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 08 Oct 2017 11:53:11 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> >  
> >> Hi Robert,
> >> Wait a bit before applying. I think patches 6 to 9 have a dependency on
> >> patch 1 (it's not a build dependency, but NAND partitioning might be
> >> wrong if you apply them), so we need to sync. What release is
> >> pxa/for-next targeting? If it's 4.15 I can apply patch 1 just after
> >> 4.14-rc1 is out and provide an immutable branch for you to pull in
> >> pxa/for-next.  
> >
> > Hi Boris,
> >
> > It's targeting 4.15 right now. And we can do as you like, either an immutable
> > branch, or I wait to include these patches into my pxa/for-next until you give
> > me your go, it's as you like.  
> 
> Hi Boris,
> 
> So what's the status about the sync, should I pick the patches, and have the
> others make it to your for-next branch ?

It's been merged in l2-mtd/master (our -next branch) which is
targeting 4.15. Unfortunately we didn't create a topic branch, which
means you'll have to wait 4.15-rc1 before pushing patches 6 to 9 if you
want avoid regressions. Anyway, I guess it's already too late to send
PRs to arm-soc for 4.15.

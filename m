From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: RE: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider	in
 host controller
Date: Thu, 30 Sep 2010 14:40:17 +0900
Message-ID: <000a01cb6061$f9fc3220$edf49660$%seo@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
 <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
 <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
 <20100917155928.GA7561@void.printf.net>
 <AANLkTimyvrSxQiF4A4pbmK8nME2ko9MRtqvcuMrY2rKR@mail.gmail.com>
 <20100930015154.GA1269@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100930015154.GA1269@void.printf.net>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, ben-linux@fluff.org, 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, '???' <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Chris wrote:

> Hi Kyungmin, Ben,
> 
> On Thu, Sep 30, 2010 at 10:18:12AM +0900, Kyungmin Park wrote:
> > On Sat, Sep 18, 2010 at 12:59 AM, Chris Ball <cjb@laptop.org> wrote:
> > > Hi,
> > >
> > > On Thu, Sep 16, 2010 at 06:08:28PM +0900, Kyungmin Park wrote:
> > >> Well there are two implementations. and no conclusion yet.
> > >> as s5pc210 don't support internal SDHCI clock, DMC overrides the
> > >> function operation itself when s5pc210. System LSI use the quirks.
> > >>
> > >> Choose any one from MMC maintainer.
> > >
> > > Both approaches are generally acceptable for MMC, so I would want to
> > > leave it up to the maintainer of the driver in question (which is Ben,
> > > in this case?) to choose between them.
> >
> > Hi Chris,
> >
> > Did you get the opinion from Ben?
> >
> > I hope this decision will be done before 2.6.37 merge windows start to
> > support SDHCI support on s5pc210.
> 
> Hm, I didn't, and Ben's been silent about the urgent sdhci-s3c patches
> too.  Ben, are you just dealing with a large backlog, or are you
> interested in nominating someone else to take over sdhci-s3c?

Hi Chris, Kyungmin

I'd like to let you know that Ben had reviewed and commented for
"[PATCH v2 2/2] sdhci-s3c: Add support no internal clock divider" in host
controller in 9/21. However, our response was late due to our holidays. I
made a response in 9/28 that why we use this quirk and now we're waiting for
his opinion.

Kyungmin, did you check Ben's review comments for this ? When I saw it, his
approach is just a bit different from you and me. Please let us know if you
have any idea about his comments.

Thanks,
Best Regards
Jeongbae Seo

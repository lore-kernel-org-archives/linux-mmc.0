From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv2 1/3] mmc: atmel-mci: move mache header to platform_data
Date: Mon, 27 Oct 2014 16:44:19 +0100
Message-ID: <20141027154419.GE22660@piout.net>
References: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413534398-22645-2-git-send-email-alexandre.belloni@free-electrons.com>
 <CAPDyKFobcRL7_+ZiEkWFGXxq5Hznf5fZcpqUP+Z6VxW67mWBEw@mail.gmail.com>
 <CAPDyKFr-pyTT=N7p+rU7mnzMg8F_rQOZvDva9GGmwy4J2t3F6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-pyTT=N7p+rU7mnzMg8F_rQOZvDva9GGmwy4J2t3F6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <chris@printf.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 27/10/2014 at 16:23:23 +0100, Ulf Hansson wrote :
> On 27 October 2014 15:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 17 October 2014 10:26, Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> wrote:
> >> Move the mach header that can come either from arm/mach-at91 or avr32 to
> >> platform_data to be able to switch the AT91 platforms to multiplatform.
> >>
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >
> > Thanks! Applied for next!
> 
> Actually this one caused a compiler error due to a moved header from
> the below commit.
> 
> 3d598f47e804 dmaengine: dw: move dw_dmac.h to where it belongs to
> 
> I decided to fix it myself and fold the change into this patch, see below.
> 

what you did seems fine. It was the same commit that conflicted with the
third patch.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

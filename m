From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 00/16] omap_hsmmc patches
Date: Fri, 2 Sep 2011 13:53:26 +0300
Message-ID: <20110902105325.GT3548@atomide.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
 <CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
 <m2k4bm2nwl.fsf@bob.laptop.org>
 <CANOLnOPGay+jQaeBAVD5-B3WQaWMSiPFirvhrPkeS0_ZgmX-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOPGay+jQaeBAVD5-B3WQaWMSiPFirvhrPkeS0_ZgmX-BQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [110715 12:27]:
> On Wed, Jul 13, 2011 at 6:36 PM, Chris Ball <cjb@laptop.org> wrote:
> > Hi,
> >
> > On Wed, Jul 13 2011, Grazvydas Ignotas wrote:
> >> it seems this series got lost in time, at least patches 01, 02, 03=
,
> >> 04, 05, 06, 07, 08, 12 look like valid standalone fixes and
> >> improvements to me, they don't touch other trees and still apply
> >> cleanly, so would be good to have.
> >
> > Yeah. =C2=A0I didn't merge them because Tony still has unanswered c=
omments on
> > the OMAP side of the patches, and they're submitted as a single pat=
chset.
> >
> > I've applied {2, 3, 5, 6, 7, 8, 12} to mmc-next for 3.1 now. =C2=A0=
1 doesn't
> > apply because the function doesn't exist anymore. =C2=A04 doesn't a=
pply
> > because iclk doesn't exist anymore.
> >
> > If someone wants to look at rebasing the rest of these against mmc-=
next
> > and resubmitting, I think that'd be useful.
>=20
> Thanks! 1 and 4 seem to be unneeded any more (I was trying them on
> linux-next, not noticing it was not updated for a while), and others
> have comments pending, so it's all done.

So I guess that means I don't need to look at anything, right?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

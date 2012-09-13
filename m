From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Thu, 13 Sep 2012 02:02:30 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org> <87liggwa1w
 <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-mmc@vger.kernel.org

> >
> >> -----Original Message-----
> >> From: Chris Ball [mailto:cjb@laptop.org]
> >> Sent: Wednesday, September 12, 2012 4:59 AM
> >> To: Kumar Gala
> >> Cc: Huang Changming-R66093; linuxppc-dev@lists.ozlabs.org list;
> >> linux- mmc@vger.kernel.org; Anton Vorontsov
> >> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the
> >> CMD23
> >>
> >> Hi,
> >>
> >> On Tue, Sep 11 2012, Kumar Gala wrote:
> >>> thanks for the info.  Do you know what's required on controller side
> >>> to handle cards that support CMD23?
> >>>
> >>> I'm trying to figure out if older controller's on FSL SoCs are
> >>> missing some feature to allow CMD23 to work (vs Auto-CMD23).
> >>
> >> It seems plausible that it's just not implemented on these controllers.
> >> It's a little strange, since the command's been specified for so long
> >> and we haven't seen any other controllers with problems.  The patch
> >> would be correct if this is true.
> >>
> >
> > I didn't find any description about it, but after testing on FSL
> silicones, I got this result:
> > Some silicones support this command, and some silicones don't support
> it, which will cause I/O error.
> 
> Can you list out which SoCs support it and which don't.  Having this list
> will be useful in understanding which controller versions supported it.
> 
P1020, p1021, p1022, p1024, p1015 and p4080 can't support it.
Mpc8536, p2020, and the other current DPAA silicon (e.g. p5020, p3041) support it.

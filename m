From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Thu, 10 Feb 2011 12:52:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102101251390.21991@utopia.booyaka.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com> <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com> <alpine.DEB.2.00.1102081622180.21991@utopia.booyaka.com> <AANLkTikLLSXGg+VMubeRs-K=EBUuna5gFwGjvn=SsPB7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-646867055-1297367573=:21991"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTikLLSXGg+VMubeRs-K=EBUuna5gFwGjvn=SsPB7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com
List-Id: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-646867055-1297367573=:21991
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Feb 2011, Kadiyala, Kishore wrote:

> On Wed, Feb 9, 2011 at 4:59 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 2 Feb 2011, Kishore Kadiyala wrote:
> >
> >> Update the omap2420 hwmod data with the HSMMC info.
> >
> > Umm, this doesn't look right. =A0OMAP2420 doesn't have an HSMMC block a=
s far
> > as I know. =A0It also uses a different driver than later OMAPs.
>=20
> OK , I will update this in V3.

Tony says that the N800 MMC slots should work with the current kernel. =20
So please test your patches on N800 before resending...


- Paul
--155748971-646867055-1297367573=:21991--

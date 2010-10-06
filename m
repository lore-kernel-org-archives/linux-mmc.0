From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 6 Oct 2010 05:55:07 -0700
Message-ID: <AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
	<20100827192248.GJ20407@void.printf.net>
	<4C7CC480.2040903@csr.com>
	<4C7F3E0F.2080402@compulab.co.il>
	<AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>
	<C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>
	<AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>
	<CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>
	<AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>
	<4CAC146D.3040001@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4CAC146D.3040001@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Madhusudhan <madhu.cr@ti.com>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 5, 2010 at 11:17 PM, Mike Rapoport <mike@compulab.co.il> wr=
ote:

> I've tried to update the patches on top of 2.6.36-rc3 and I've got st=
uck.
> The changes Adrian has made to the interrupt synchronization =A0affec=
t the way
> the
> SDIO irq should be implemented and I haven't found a way to resolve i=
t :-(

I tried my hand at making the patch apply on 2.6.35:

http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dco=
mmitdiff;h=3D51b802d73191c306618cddefbd63379c839589f5

It seems to work, but I'm pretty sure I must have messed something up
because I get error messages every once in a while:

libertas: tx watch dog timeout

I don't recall seeing these with the original version of the patch :-(

Suggestions as to where I went wrong are welcome!

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

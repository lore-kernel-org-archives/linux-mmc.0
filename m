From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: RE: RFC: Shared eMMC Controller
Date: Tue, 13 Oct 2009 14:32:43 -0700
Message-ID: <0D4616E6925F9541919B60692F61509E43AAA8B5@orsmsx502.amr.corp.intel.com>
References: <0D4616E6925F9541919B60692F61509E43AAA2A7@orsmsx502.amr.corp.intel.com>
 <c09aa50a0910131428t744c8334ia814a6a365ab51a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59509 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbZJMVdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2009 17:33:21 -0400
In-Reply-To: <c09aa50a0910131428t744c8334ia814a6a365ab51a7@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

While they will share the controller, they will not share partitions.  =
So there is no file system level sharing.
Just the controller.    Also the granularity would be at the command le=
vel.  We won't cut short any command in progress.

-----Original Message-----
=46rom: spyro2@gmail.com [mailto:spyro2@gmail.com] On Behalf Of Ian Mol=
ton
Sent: Tuesday, October 13, 2009 2:29 PM
To: Johnson, Charles F
Subject: Re: RFC: Shared eMMC Controller

I cant see that being a problem. I wonder how fine grained the access
would be though - having mounted filesystems would mean that the other
systtem would risk getting vorrupt data and I doubt your mutexes could
be that low level.

As an alternative, why dont you probe / remove the driver when not used=
?

2009/10/13 Johnson, Charles F <charles.f.johnson@intel.com>:
> I'm working on a system where we have a need to share the eMMC host c=
ontroller with both the main CPU and a micro-controller. =A0So to coodi=
nate access we need to define a mutex mechanism between the two. =A0Thi=
s is possible since there is some shared non-cachable static ram that b=
oth have access to. =A0My question for this email list is, if we limit =
the mmc driver changes to use the chipset specific quirk mechanism, wou=
ld that be acceptable ??
>
> As soon as we have the code, we'll post it, but I am interested in an=
y comments.
>
> Thanks.
>
> Charles Johnson
> Intel Corp.
> charles.f.johnson@intel.com
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/

From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: RFC: Adding HPI to prioritize Reads or Writes
Date: Fri, 11 Jun 2010 17:04:12 +0900
Message-ID: <AANLkTimjD57YDDfqVyyrp9Wndv3ji-4DZpGgUP1tpVAh@mail.gmail.com>
References: <AcsHNl6lyMhuBaR9Qf6Y8+dS3Xc35Q==>
	<0D4616E6925F9541919B60692F61509E67517A6F@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39631 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0FKIEO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 04:04:14 -0400
Received: by pvg16 with SMTP id 16so374236pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2010 01:04:13 -0700 (PDT)
In-Reply-To: <0D4616E6925F9541919B60692F61509E67517A6F@orsmsx502.amr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Johnson, Charles F" <charles.f.johnson@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Iqbal <iqbal.ams@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Wed, Jun 9, 2010 at 3:14 AM, Johnson, Charles F
<charles.f.johnson@intel.com> wrote:
> Folks - I'm wondering what this list thinks of making a change to the=
 mmc driver to make use the the High Priority Interrupt (HPI) feature t=
hat was added in the eMMC 4.41 spec to give priority to reads over writ=
es. =A0Part of this could be writing a custom i/o scheduler that just r=
esorts the requests on the queue so that reads are always favored. =A0(=
And obviously taking into account where a read is dependent on a previo=
us write.) =A0But the secondary ideas is to use HPI to interrupt a writ=
e in progress as long as the incoming read isn't depending on the write=
=2E =A0Then the write would have to finished later, I guess. =A0So my q=
uestion for this list is, is this even feasible ?? =A0Only the i/o sche=
duler knows if of incoming reads. =A0The driver itself just knows about=
 the current request. =A0Does the i/o scheduler know what request is in=
 progress ?? =A0(CFQ scheduler for example.)

Hi, I also interested in HPI. I saw the spec. but no ideas.
1. make a custom I/O scheduler is not good idea since we don't know
what's the next request and can't wait for read for HPI.
   most important reason we don't want to dependent on I/O scheduler.
just MMC framework is enough.
2. I prefer mmc request handling method and it's same as spec. my main
concern is how to interrupt the request operation while write
operation. it's same consideration as Johnson. I'm not yet find a
idea.

Thank you,
Kyungmin Park

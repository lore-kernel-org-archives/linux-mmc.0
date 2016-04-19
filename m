From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Tue, 19 Apr 2016 09:13:30 -0700
Message-ID: <5716592A.6000505@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org> <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org> <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org> <CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0067.outbound.protection.outlook.com ([207.46.100.67]:11177
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933246AbcDSQNi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 12:13:38 -0400
In-Reply-To: <CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On 04/19/2016 02:15 AM, Ulf Hansson wrote:
[...]
>
>  From this discussion I have understood that we clearly need a way to
> describe mmc slots in DT!
>
> Unfortunate we should have discussed this before you decided to ship
> devices with DTBs containing non accepted DT bindings, but hey better
> late than never! :-)

This is a point where the DT and mmc maintainers have a continual 
misunderstanding of the facts.

There were requests to discuss the binding as far back as 2012:

https://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html

They were met with silence.

The firmware containing these bindings is out in the wild.  If we 
deprecate some of the bindings, the driver will still have to support 
them in the future.

In the case of OCTEON based devices, the device tree bindings are a 
firmware <--> kernel ABI as the device trees always come from the 
firmware and not some other place.

David Daney

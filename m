From: Sean Straw <sstraw@enphaseenergy.com>
Subject: Re: Question on mmc utils write reliability
Date: Thu, 26 Jan 2017 21:55:34 +0000
Message-ID: <BY2PR0201MB192750E01D75A4C5994CE3D0C3770@BY2PR0201MB1927.namprd02.prod.outlook.com>
References: <SN1PR0201MB1934E741FB1C67BC01D0DBE2C3720@SN1PR0201MB1934.namprd02.prod.outlook.com>,<7a5ff950-017c-5c87-9a14-bbf22a445771@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:61256
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753067AbdAZWLc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Jan 2017 17:11:32 -0500
In-Reply-To: <7a5ff950-017c-5c87-9a14-bbf22a445771@vaisala.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>


Thank you for the reply.


git://git.kernel.org/pub/scm/linux/kernel.git/cjb/mmc-utils.git
commit 2cb6695e8dec00d887bdd5309d1b57d836fcd214

(which is the HEAD of origin/master for about 5 months now)


I was under the understanding that reliable write was throttling the eMMC t=
o single block operations.  Unless I've misread the JESD84-B51, enh_area is=
 pSLC mode, which results in halving usable flash capacity - providing more=
 reliable operation, but being separate from the one-block-per-operation of=
 reliable_write.  Is reliable write really not available for full capacity =
MLC ?

Section 6.2.4 of the above references JEDC document (although the 5.1 stand=
ard) pertains to the partitioning sequence, and the flowchart there does no=
t make reference to the write_reliability as part of partitioning itself.

(my first reply early yesterday morning apparently went into the bitbucket)=
.
The information contained in this message may be privileged and confidentia=
l. It is intended to be read only by the individual or entity to whom it is=
 addressed or by their designee. If the reader of this message is not the i=
ntended recipient, you are on notice that any distribution of this message,=
 in any form, is strictly prohibited. If you have received this message in =
error, please immediately notify the sender and delete or destroy any copy =
of this message!

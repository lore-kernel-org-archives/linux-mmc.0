From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: RE: Features vs versions (Was: Patch: eMMC boot partition needs to
 be deactivated for linux to find user partitions)
Date: Mon, 15 Mar 2010 11:54:45 -0700
Message-ID: <0D4616E6925F9541919B60692F61509E59BF24EC@orsmsx502.amr.corp.intel.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com> <4B9E7D4D.1030807@efalk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45843 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965653Ab0COS4r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2010 14:56:47 -0400
In-Reply-To: <4B9E7D4D.1030807@efalk.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Edward Falk <falk@efalk.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

At the back of the document is a change list for each revision.  On the 84-A44 spec I have it is Annex B, on page 209. 

Charles Johnson
Ultra-Mobility Group
UPSG Architecture
Intel Corporation
charles.f.johnson@intel.com
 

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Edward Falk
Sent: Monday, March 15, 2010 11:33 AM
To: linux-mmc@vger.kernel.org
Subject: Features vs versions (Was: Patch: eMMC boot partition needs to be deactivated for linux to find user partitions)

Adrian Hunter wrote:

> That switch command should not be used for devices that do not
> support it e.g. eMMC 4.3 and before.

I've been wondering about this -- how can you tell which feature is 
available in which version of the standard?  I have 84-A44 in front of 
me now, and I can't see it.  Do I need to just obtain older versions of 
the standards doc and compare them by hand?

	-ed falk
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

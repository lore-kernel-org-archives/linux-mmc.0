From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: Comment Needed: Shared eMMC controller
Date: Tue, 22 Sep 2009 15:19:43 -0700
Message-ID: <0D4616E6925F9541919B60692F61509E4353FDD0@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37592 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZIVWTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 18:19:42 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I'd like to get some feedback from the eMMC/MMC/SD driver community.  We are considering a design where we need to share the eMMC controller between the main host CPU and a secondary microcontroller.  A hardware mutex would be added to coordinate access.
My question here is, if we added this thru the quirks mechanisms, would this be "upstream acceptable" ?  Would it be better to do it thru a Kconfig option ?  What other problems could we run into ?

Charles Johnson
Ultra-Mobility Group
UPSG Architecture
Intel Corporation
charles.f.johnson@intel.com
 

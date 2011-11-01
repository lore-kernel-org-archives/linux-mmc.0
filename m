From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/4] mmc: sdhci-pci: add platform data
Date: Tue, 01 Nov 2011 08:27:48 +0200
Message-ID: <4EAF9164.4060102@intel.com>
References: <1319794437-16870-1-git-send-email-adrian.hunter@intel.com> <1319794437-16870-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55140 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab1KAG1u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Nov 2011 02:27:50 -0400
In-Reply-To: <1319794437-16870-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 28/10/11 12:33, Adrian Hunter wrote:
> Add a means of getting platform data for the SDHCI PCI
> devices.

This is no good.  It does not allow for support for multiple
platforms to be compiled-in together.  I will try again...

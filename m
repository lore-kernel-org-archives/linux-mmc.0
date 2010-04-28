From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
Date: Wed, 28 Apr 2010 11:22:45 -0700
Message-ID: <20100428112245.23e99d70.akpm@linux-foundation.org>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55021 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218Ab0D1SXB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2010 14:23:01 -0400
In-Reply-To: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: haavard.skinnemoen@atmel.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@avr32linux.org

Patches 1-3 (at least) appear to be applicable to 2.6.33.x and perhaps
earlier.

But you didn't cc stable@kernel.org and there was no Cc:
<stable@kernel.org> in the changelog and in this case I'd prefer not to
make that decision myself?


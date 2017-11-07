From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mmc : implement REQ_OP_WRITE_ZEROES
Date: Tue, 7 Nov 2017 08:10:03 +0100
Message-ID: <20171107071003.GA13146@lst.de>
References: <20171107070259.11664-1-js07.lee@samsung.com> <CGME20171107070328eucas1p12d563f31022e62a4ac6daac26fb0b81d@eucas1p1.samsung.com> <20171107070259.11664-2-js07.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50335 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbdKGHKF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Nov 2017 02:10:05 -0500
Content-Disposition: inline
In-Reply-To: <20171107070259.11664-2-js07.lee@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jungseung Lee <js07.lee@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>, js07.lee@gmail.com, linux-mmc@vger.kernel.org

Please send a long the patch to actually set the flag, else it is just
dead code.

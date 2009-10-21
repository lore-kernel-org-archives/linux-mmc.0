From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] Disk hot removal causing oopses and fixes
Date: Wed, 21 Oct 2009 23:19:41 +0200
Message-ID: <4ADF7AED.2030506@s5r6.in-berlin.de>
References: <20091021161201.GA16968@angel.research.nokia.com> <4ADF752D.7010206@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755491AbZJUVTo@vger.kernel.org>
In-Reply-To: <4ADF752D.7010206@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Stefan Richter wrote:
> I dare say without knowing the MMC and block system:  It is not a
> locking issue, it is a reference counting issue.
[...]
> The whole secret is not to forget to count _all_ references.

PS, in case that it might be needed:  Sometimes a low level wants to
wait for the moment until its upper level users went away.  Reference
counting is then coupled with constructs like wait_for_completion then.
-- 
Stefan Richter
-=====-==--= =-=- =-=-=
http://arcgraph.de/sr/

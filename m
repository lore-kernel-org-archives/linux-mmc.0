From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Date: Wed, 8 May 2019 23:04:56 -0700
Message-ID: <20190509060456.GA17096@infradead.org>
References: <20190508185833.187068-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190508185833.187068-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 08, 2019 at 12:58:32PM -0600, Raul E Rangel wrote:
> It is possible for queuedata to be cleared in mmc_cleanup_queue before
> the request has been started.

Errm.  I think we need to fix that problem instead of working around it.

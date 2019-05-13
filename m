From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Date: Mon, 13 May 2019 11:19:08 -0600
Message-ID: <20190513171908.GA37248@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
 <20190509184234.GA197434@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190509184234.GA197434@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

> > Errm.  I think we need to fix that problem instead of working around it.
> So mmc_request_fn already has a null check, it was just missing on
> mmc_init_request.
>
So I got 189650 random connect/disconnect iterations over the weekend
with these patches. I think they are fine. I'm going to send them to
stable@ unless anyone has any objections.

Thanks,
Raul

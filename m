From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mmc: Fix tag set memory leak
Date: Thu, 2 May 2019 14:11:51 -0600
Message-ID: <9233014c-8528-6cae-c48a-5b75160fa100@kernel.dk>
References: <20190502190714.181664-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502190714.181664-1-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com, djkurtz@chromium.org, zwisler@chromium.org, Ming Lei <ming.lei@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 5/2/19 1:07 PM, Raul E Rangel wrote:
> The tag set is allocated in mmc_init_queue but never freed. This results
> in a memory leak. This change makes sure we free the tag set when the
> queue is also freed.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

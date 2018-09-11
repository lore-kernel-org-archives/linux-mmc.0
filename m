From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in
 ISR
Date: Tue, 11 Sep 2018 19:00:53 +0300
Message-ID: <1c5cd9ec-3c33-0ad8-d1bf-a5d3883c9e5c@mleia.com>
References: <20180911144701.53383-1-hangdianqj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911144701.53383-1-hangdianqj@163.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jun qian <hangdianqj@163.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 09/11/2018 05:47 PM, jun qian wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

---
Best wishes,
Vladimir

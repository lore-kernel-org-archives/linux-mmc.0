From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] mmc: host: fix potential null pointer dereference
Date: Thu, 25 May 2017 11:12:08 +0200 (CEST)
Message-ID: <746018130.108142.1495703528403@email.1und1.de>
References: <20170523234227.GA13018@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170523234227.GA13018@embeddedgus>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Gustavo,

> "Gustavo A. R. Silva" <garsilva@embeddedor.com> hat am 24. Mai 2017 um 01:42 geschrieben:
> 
> 
> Null check at line 1165: if (mrq->cmd), implies that mrq->cmd might
> be NULL.
> Add null checks before dereferencing pointer mrq->cmd in order to avoid
> any potential NULL pointer dereference.
> 
> Addresses-Coverity-ID: 1408740
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

with a Raspberry Pi Zero.

But please change the subject to make sure it's bcm2835 related:

mmc: bcm2835: fix potential null pointer dereferences

Thanks
Stefan

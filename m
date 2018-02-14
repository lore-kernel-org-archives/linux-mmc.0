From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Wed, 14 Feb 2018 15:58:31 +0100
Message-ID: <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Suchanek <msuchanek@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Michal,

Am 14.02.2018 um 15:38 schrieb Michal Suchanek:
> The bcm2835 mmc host tends to lock up for unknown reason so reset it on
> timeout. The upper mmc block layer tries retransimitting with single
> blocks which tends to work out after a long wait.
>
> This is better than giving up and leaving the machine broken for no
> obvious reason.

could you please provide more information about this issue (affected
hardware, kernel config, version, dmesg, reproducible scenario)?

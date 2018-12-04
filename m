From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 7/7] mmc: bcm2835: Properly handle
 dmaengine_prep_slave_sg
Date: Tue, 4 Dec 2018 19:20:59 +0100 (CET)
Message-ID: <1382521023.341849.1543947659588@email.ionos.de>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
 <87y39d5czn.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87y39d5czn.fsf@anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

> Eric Anholt <eric@anholt.net> hat am 28. November 2018 um 18:27 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> This series is:
> 
> Acked-by: Eric Anholt <eric@anholt.net>

should i resend with Eric's Ack?

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] pxamci: remove the ifdef CONFIG_REGULATOR
Date: Wed, 11 May 2011 15:07:05 +0200
Message-ID: <20110511130705.GA12469@opensource.wolfsonmicro.com>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
	<1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 11, 2011 at 12:19:05PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an ifdef CONFIG_REGULATOR anymore, as
> now it degenerates and returns NULL when the regulator framework is
> disabled (since commit be1a50d: regulator: Let drivers know when they
> use the stub API); and use IS_ERR_OR_NULL() to handle the stub function 
> correctly.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

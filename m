From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/9] Revert "Documentation: dw-mshc: deprecate num-slots"
Date: Fri, 13 Oct 2017 14:28:41 -0500
Message-ID: <20171013192841.6axxu5uvotohbbik@rob-hp-laptop>
References: <cover.1507315433.git.lsun@mellanox.com>
 <7deccd8a59339ef0ca5c1d54eb453d040b7df594.1507315433.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7deccd8a59339ef0ca5c1d54eb453d040b7df594.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 06, 2017 at 03:21:24PM -0400, Liming Sun wrote:
> This reverts commit 3f5b4b79d4c0fa71fd7d74c2a44bbc0869c04c9b.
> 
> The Mellanox BlueField SoC requires multiple slot dw-mmc support.
> 
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt         | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
